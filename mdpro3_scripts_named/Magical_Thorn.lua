--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 魔力之棘  (ID: 53119267)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方的手卡丢弃去墓地时，每丢弃1张卡就给与对方基本分500分的伤害。
--[[ __CARD_HEADER_END__ ]]

--魔力の棘
function c53119267.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetOperation(c53119267.damop)
	c:RegisterEffect(e2)
end
function c53119267.filter(c,tp)
	return c:IsPreviousLocation(LOCATION_HAND) and c:IsControler(1-tp) and c:IsPreviousControler(1-tp)
		and c:IsReason(REASON_DISCARD)
end
function c53119267.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c53119267.filter,nil,tp)
	Duel.Damage(1-tp,ct*500,REASON_EFFECT)
end
