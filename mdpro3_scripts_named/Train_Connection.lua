--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 机关连接  (ID: 60879050)
-- Type: Spell / Field
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己墓地2只10星以上的机械族怪兽除外发动的场合才能给机械族·地属性怪兽装备。
-- ①：装备怪兽的攻击力变成原本攻击力的2倍，装备怪兽向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
-- ②：只要这张卡在魔法与陷阱区域存在，装备怪兽以外的自己怪兽不能攻击。
--[[ __CARD_HEADER_END__ ]]

--機関連結
function c60879050.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetCost(c60879050.cost)
	e1:SetTarget(c60879050.target)
	e1:SetOperation(c60879050.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c60879050.eqlimit)
	c:RegisterEffect(e2)
	--Atk Change
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetValue(c60879050.value)
	c:RegisterEffect(e3)
	--Pierce
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e4)
	--cannot attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_ATTACK)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetTarget(c60879050.ftarget)
	c:RegisterEffect(e5)
end
function c60879050.eqlimit(e,c)
	return e:GetHandler():GetEquipTarget()==c and c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_EARTH)
end
function c60879050.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_EARTH)
end
function c60879050.rmfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsLevelAbove(10) and c:IsAbleToRemoveAsCost()
end
function c60879050.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60879050.rmfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c60879050.rmfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c60879050.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c60879050.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60879050.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c60879050.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c60879050.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c60879050.value(e,c)
	return c:GetBaseAttack()*2
end
function c60879050.ftarget(e,c)
	return e:GetHandler():GetEquipTarget()~=c
end
