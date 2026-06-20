--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 娱乐伙伴 调级钟行李员  (ID: 3752422)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Fairy
-- Level 6
-- Pendulum Scales: L1 / R1
-- ATK 100 | DEF 2600
-- Setcode: 159
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- ①：1回合1次，自己主要阶段才能发动。自己场上的灵摆召唤的全部怪兽的等级上升1星。
-- 【怪兽效果】
-- ①：1回合1次，宣言1～5的任意等级，以这张卡以外的自己场上1只「娱乐伙伴」怪兽为对象才能发动。直到回合结束时，这张卡的等级下降宣言的等级数值，作为对象的怪兽的等级上升宣言的等级数值。
--[[ __CARD_HEADER_END__ ]]

--EMレ・ベルマン
function c3752422.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--level up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3752422,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c3752422.lvtg)
	e1:SetOperation(c3752422.lvop)
	c:RegisterEffect(e1)
	--level change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3752422,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c3752422.target)
	e2:SetOperation(c3752422.operation)
	c:RegisterEffect(e2)
end
function c3752422.lvfilter(c)
	return c:IsFaceup() and c:IsSummonType(SUMMON_TYPE_PENDULUM) and c:GetLevel()>0
end
function c3752422.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3752422.lvfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c3752422.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(c3752422.lvfilter,tp,LOCATION_MZONE,0,nil)
	local tc=tg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
		tc:RegisterEffect(e1)
		tc=tg:GetNext()
	end
end
function c3752422.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f) and c:GetLevel()>0
end
function c3752422.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc~=c and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c3752422.filter(chkc) end
	if chk==0 then return c:GetLevel()>1
		and Duel.IsExistingTarget(c3752422.filter,tp,LOCATION_MZONE,0,1,c) end
	local p=c:GetLevel()-1
	p=math.min(p,5)
	Duel.Hint(HINT_SELECTMSG,tp,HINGMSG_LVRANK)
	e:SetLabel(Duel.AnnounceLevel(tp,1,p))
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c3752422.filter,tp,LOCATION_MZONE,0,1,1,c)
end
function c3752422.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lv=e:GetLabel()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(-lv)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local tc=Duel.GetFirstTarget()
		if tc:IsFaceup() and tc:IsRelateToEffect(e) then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_LEVEL)
			e2:SetValue(lv)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
		end
	end
end
