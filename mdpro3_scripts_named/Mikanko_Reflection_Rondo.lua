--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 御巫的诱轮舞  (ID: 79912449)
-- Type: Spell / Field
-- ATK 0 | DEF 0
-- Setcode: 397
--
-- Effect Text:
-- 可以给对方场上的怪兽装备。这个卡名的卡在1回合只能发动1张。
-- ①：「御巫的诱轮舞」在自己场上只能有1张表侧表示存在。
-- ②：只要自己场上有「御巫」怪兽存在，得到装备怪兽的控制权。
-- ③：装备怪兽只要在自己场上存在，不能把效果发动。
-- ④：这张卡从场上离开时装备怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--御巫の誘い輪舞
function c79912449.initial_effect(c)
	c:SetUniqueOnField(1,0,79912449)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetCountLimit(1,79912449+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c79912449.target)
	e1:SetOperation(c79912449.activate)
	c:RegisterEffect(e1)
	--Equip Limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c79912449.eqlimit)
	c:RegisterEffect(e2)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_SET_CONTROL)
	e3:SetCondition(c79912449.ctcon)
	e3:SetValue(c79912449.ctval)
	c:RegisterEffect(e3)
	--cannot trigger
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_CANNOT_TRIGGER)
	e4:SetCondition(c79912449.con)
	c:RegisterEffect(e4)
	--to grave
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e5:SetCode(EVENT_LEAVE_FIELD)
	e5:SetOperation(c79912449.tgop)
	c:RegisterEffect(e5)
end
function c79912449.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c79912449.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(1-tp) then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c79912449.eqlimit(e,c)
	return e:GetHandlerPlayer()~=c:GetControler() or e:GetHandler():GetEquipTarget()==c
end
function c79912449.filter(c)
	return c:IsSetCard(0x18d) and c:IsFaceup()
end
function c79912449.ctcon(e)
	return Duel.IsExistingMatchingCard(c79912449.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c79912449.ctval(e,c)
	return e:GetHandlerPlayer()
end
function c79912449.con(e)
	return e:GetHandler():GetEquipTarget():IsControler(e:GetHandlerPlayer())
end
function c79912449.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
