--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 自然蝴蝶  (ID: 42110434)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Insect
-- Level 3
-- ATK 500 | DEF 1200
-- Setcode: 42
--
-- Effect Text:
-- 1回合1次，对方怪兽的攻击宣言时才能发动。把自己卡组最上面1张卡送去墓地，那次攻击无效。
--[[ __CARD_HEADER_END__ ]]

--ナチュル・バタフライ
function c42110434.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42110434,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c42110434.condition)
	e1:SetTarget(c42110434.target)
	e1:SetOperation(c42110434.operation)
	c:RegisterEffect(e1)
end
function c42110434.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():GetControler()~=tp
end
function c42110434.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c42110434.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
	Duel.NegateAttack()
end
