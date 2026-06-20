--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 破灭之女神 露茵  (ID: 46427957)
-- Type: Monster / Effect / Ritual
-- Attribute: LIGHT
-- Race: Fairy
-- Level 8
-- ATK 2300 | DEF 2000
--
-- Effect Text:
-- 「世界末日」降临。
-- ①：这张卡的攻击破坏对方怪兽时才能发动。这张卡只再1次可以继续攻击。
--[[ __CARD_HEADER_END__ ]]

--破滅の女神ルイン
function c46427957.initial_effect(c)
	aux.AddCodeList(c,8198712)
	c:EnableReviveLimit()
	--chain attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46427957,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c46427957.atcon)
	e1:SetOperation(c46427957.atop)
	c:RegisterEffect(e1)
end
function c46427957.atcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.bdocon(e,tp,eg,ep,ev,re,r,rp) and e:GetHandler():IsChainAttackable()
end
function c46427957.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
