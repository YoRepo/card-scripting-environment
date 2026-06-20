--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 异国的剑士  (ID: 85255550)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 1
-- ATK 250 | DEF 250
--
-- Effect Text:
-- 受到「异国的剑士」攻击的怪兽，5回合后被破坏。
--[[ __CARD_HEADER_END__ ]]

--異国の剣士
function c85255550.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(85255550,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c85255550.condition)
	e1:SetOperation(c85255550.operation)
	c:RegisterEffect(e1)
end
function c85255550.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c==Duel.GetAttacker() and bc and bc:IsRelateToBattle() and bc:IsFaceup()
end
function c85255550.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetRange(LOCATION_MZONE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetOperation(c85255550.desop)
		e1:SetLabel(0)
		e1:SetOwnerPlayer(tp)
		bc:RegisterEffect(e1)
	end
end
function c85255550.desop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	ct=ct+1
	e:SetLabel(ct)
	e:GetOwner():SetTurnCounter(ct)
	if ct==5 then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
