--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 爆炎少女  (ID: 64752646)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 4
-- ATK 1300 | DEF 1500
--
-- Effect Text:
-- 每次自己的基本分回复，对方受到500分的伤害。
--[[ __CARD_HEADER_END__ ]]

--ビッグバンガール
function c64752646.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64752646,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_RECOVER)
	e1:SetCondition(c64752646.cd)
	e1:SetOperation(c64752646.op)
	c:RegisterEffect(e1)
end
function c64752646.cd(e,tp,eg,ep,ev,re,r,rp)
	return tp==ep
end
function c64752646.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,500,REASON_EFFECT)
end
