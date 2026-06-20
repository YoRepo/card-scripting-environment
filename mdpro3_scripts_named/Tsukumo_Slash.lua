--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 九十九斩  (ID: 25334372)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「九十九斩」在1回合只能发动1张。
-- ①：自己怪兽向比那只怪兽攻击力高的怪兽攻击的伤害计算时才能发动。那只进行战斗的自己怪兽的攻击力只在那次伤害计算时上升自己和对方的基本分差的数值。
--[[ __CARD_HEADER_END__ ]]

--九十九スラッシュ
function c25334372.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCountLimit(1,25334372+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c25334372.atkcon)
	e1:SetOperation(c25334372.atkop)
	c:RegisterEffect(e1)
end
function c25334372.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	return a:IsControler(tp) and a:GetAttack()<d:GetAttack() and Duel.GetLP(tp)~=Duel.GetLP(1-tp)
end
function c25334372.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=Duel.GetAttacker()
	if c:IsFaceup() and c:IsRelateToBattle() then
		local atk=math.abs(Duel.GetLP(tp)-Duel.GetLP(1-tp))
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(atk)
		c:RegisterEffect(e1)
	end
end
