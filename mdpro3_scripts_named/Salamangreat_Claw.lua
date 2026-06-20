--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 转生炎兽的烈爪  (ID: 88540324)
-- Type: Spell / Field
-- ATK 0 | DEF 0
-- Setcode: 281
--
-- Effect Text:
-- 「转生炎兽」怪兽才能装备。
-- ①：「转生炎兽的烈爪」在自己场上只能有1张表侧表示存在。
-- ②：装备怪兽不会被战斗·效果破坏，向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
-- ③：装备怪兽是用和自身同名的怪兽为素材作连接召唤的自己的「转生炎兽」连接怪兽的场合，装备怪兽在同1次的战斗阶段中可以向怪兽作出最多有那个连接标记数量的攻击。
--[[ __CARD_HEADER_END__ ]]

--転生炎獣の烈爪
function c88540324.initial_effect(c)
	c:SetUniqueOnField(1,0,88540324)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetTarget(c88540324.target)
	e1:SetOperation(c88540324.operation)
	c:RegisterEffect(e1)
	--equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c88540324.eqlimit)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e4)
	--pierce
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e5)
	--extra attack
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP)
	e6:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
	e6:SetValue(c88540324.atkval)
	c:RegisterEffect(e6)
	if not c88540324.global_check then
		c88540324.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
		ge1:SetCode(EFFECT_MATERIAL_CHECK)
		ge1:SetValue(c88540324.valcheck)
		Duel.RegisterEffect(ge1,0)
	end
end
function c88540324.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsLinkCode,1,nil,c:GetCode()) then
		c:RegisterFlagEffect(88540324,RESET_EVENT+0x4fe0000,0,1)
	end
end
function c88540324.eqlimit(e,c)
	return c:IsSetCard(0x119)
end
function c88540324.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x119)
end
function c88540324.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c88540324.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c88540324.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c88540324.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c88540324.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c88540324.atkval(e,c)
	local c=e:GetHandler()
	local tc=c:GetEquipTarget()
	local ct=0
	if tc:IsControler(e:GetHandlerPlayer()) and tc:IsSetCard(0x119) and tc:IsSummonType(SUMMON_TYPE_LINK) and tc:GetFlagEffect(88540324)~=0 then
		ct=tc:GetLink()
	end
	return math.max(0,ct-1)
end
