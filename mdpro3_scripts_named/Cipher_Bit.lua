--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 光波防轮  (ID: 99397762)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 229
--
-- Effect Text:
-- ①：以自己场上1只「银河眼」超量怪兽或者「光波」超量怪兽为对象才能发动。把这张卡在那只怪兽下面重叠作为超量素材，那只怪兽在这个回合只有1次不会被战斗·效果破坏。
--[[ __CARD_HEADER_END__ ]]

--光波防輪
function c99397762.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c99397762.target)
	e1:SetOperation(c99397762.activate)
	c:RegisterEffect(e1)
end
function c99397762.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x107b,0xe5)
end
function c99397762.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c99397762.filter(chkc) end
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE)
		and e:GetHandler():IsCanOverlay()
		and Duel.IsExistingTarget(c99397762.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c99397762.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c99397762.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) and c:IsRelateToEffect(e) and c:IsCanOverlay() then
		c:CancelToGrave()
		Duel.Overlay(tc,Group.FromCards(c))
		--
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCountLimit(1)
		e1:SetValue(c99397762.indval)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c99397762.indval(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
