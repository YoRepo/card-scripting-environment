--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 大日球体  (ID: 75886890)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Machine
-- Level 1
-- ATK 400 | DEF 400
-- Setcode: 48
--
-- Effect Text:
-- ①：这张卡从怪兽区域送去墓地的场合，支付500基本分，以自己场上1只表侧表示怪兽为对象才能发动。这张卡当作装备卡使用给那只自己怪兽装备。
-- ②：把当作装备卡使用的这张卡送去墓地，以这张卡装备过的怪兽可以装备的自己墓地1张装备魔法卡为对象才能发动。这张卡装备过的怪兽把作为对象的卡装备。
--[[ __CARD_HEADER_END__ ]]

--ヴァイロン・スフィア
function c75886890.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75886890,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c75886890.eqcon)
	e1:SetCost(c75886890.eqcost)
	e1:SetTarget(c75886890.eqtg)
	e1:SetOperation(c75886890.eqop)
	c:RegisterEffect(e1)
	--equip2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75886890,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c75886890.eqcost2)
	e2:SetTarget(c75886890.eqtg2)
	e2:SetOperation(c75886890.eqop2)
	c:RegisterEffect(e2)
end
function c75886890.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE)
end
function c75886890.eqcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c75886890.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c75886890.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Equip(tp,c,tc)
		--equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(c75886890.eqlimit)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
	end
end
function c75886890.eqlimit(e,c)
	local tp=e:GetHandlerPlayer()
	return c:IsControler(tp)
end
function c75886890.eqcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	e:SetLabelObject(e:GetHandler():GetEquipTarget())
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c75886890.filter2(c,ec)
	return c:IsType(TYPE_EQUIP) and c:CheckEquipTarget(ec)
end
function c75886890.eqtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ec=e:GetHandler():GetEquipTarget()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c75886890.filter2(chkc,ec) end
	if chk==0 then return ec and Duel.IsExistingTarget(c75886890.filter2,tp,LOCATION_GRAVE,0,1,nil,ec) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(75886890,2))
	Duel.SelectTarget(tp,c75886890.filter2,tp,LOCATION_GRAVE,0,1,1,nil,e:GetLabelObject())
	e:GetLabelObject():CreateEffectRelation(e)
end
function c75886890.eqop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local ec=e:GetLabelObject()
	if tc:IsRelateToEffect(e) then
		Duel.Equip(tp,tc,ec)
	end
end
