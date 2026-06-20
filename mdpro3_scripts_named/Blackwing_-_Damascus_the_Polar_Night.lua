--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 黑羽-极夜之大马士革刀鸟  (ID: 58131925)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 3
-- ATK 1300 | DEF 700
-- Setcode: 51
--
-- Effect Text:
-- ①：把这张卡从手卡丢弃，以自己场上1只「黑羽」怪兽为对象才能发动。那只怪兽的攻击力直到回合结束时上升500。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--BF－極夜のダマスカス
function c58131925.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58131925,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(aux.dscon)
	e1:SetCost(c58131925.cost)
	e1:SetTarget(c58131925.target)
	e1:SetOperation(c58131925.operation)
	c:RegisterEffect(e1)
end
function c58131925.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c58131925.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x33)
end
function c58131925.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c58131925.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c58131925.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c58131925.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c58131925.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
