--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 次元壁  (ID: 67095270)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方怪兽的攻击宣言时才能发动。这次战斗让自己受到的战斗伤害，作为代替由对方承受。
--[[ __CARD_HEADER_END__ ]]

--ディメンション・ウォール
function c67095270.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c67095270.condition)
	e1:SetOperation(c67095270.activate)
	c:RegisterEffect(e1)
end
function c67095270.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c67095270.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
