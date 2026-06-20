--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 幻蝶的守护  (ID: 63630268)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择场上表侧攻击表示存在的1只怪兽才能发动。选择的怪兽变成表侧守备表示。这张卡发动的回合，自己受到的全部伤害变成一半。
--[[ __CARD_HEADER_END__ ]]

--幻蝶の護り
function c63630268.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c63630268.target)
	e1:SetOperation(c63630268.operation)
	c:RegisterEffect(e1)
end
function c63630268.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition()
end
function c63630268.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c63630268.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c63630268.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	Duel.SelectTarget(tp,c63630268.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c63630268.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsPosition(POS_FACEUP_ATTACK) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CHANGE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetValue(c63630268.damval)
		e1:SetReset(RESET_PHASE+PHASE_END,1)
		Duel.RegisterEffect(e1,tp)
	end
end
function c63630268.damval(e,re,val,r,rp,rc)
	return math.floor(val/2)
end
