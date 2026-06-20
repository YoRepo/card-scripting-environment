--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 电蜥蜴  (ID: 55875323)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Thunder
-- Level 3
-- ATK 850 | DEF 800
--
-- Effect Text:
-- 不死族以外的怪兽攻击这张卡的场合，那只怪兽下一个回合不能攻击宣言。
--[[ __CARD_HEADER_END__ ]]

--でんきトカゲ
function c55875323.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55875323,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c55875323.condition)
	e1:SetOperation(c55875323.operation)
	c:RegisterEffect(e1)
end
function c55875323.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttackTarget() and not Duel.GetAttacker():IsRace(RACE_ZOMBIE)
end
function c55875323.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetCondition(c55875323.atkcon)
		e1:SetOwnerPlayer(tp)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
		tc:RegisterEffect(e1)
	end
end
function c55875323.atkcon(e)
	return Duel.GetTurnCount()~=e:GetLabel() and Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end
