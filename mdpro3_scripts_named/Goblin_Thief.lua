--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 哥布林盗贼  (ID: 45311864)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 172
--
-- Effect Text:
-- ①：给与对方500伤害。自己回复500基本分。
--[[ __CARD_HEADER_END__ ]]

--盗人ゴブリン
function c45311864.initial_effect(c)
	--recover&damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_DAMAGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c45311864.target)
	e1:SetOperation(c45311864.operation)
	c:RegisterEffect(e1)
end
function c45311864.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c45311864.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,500,REASON_EFFECT,true)
	Duel.Recover(tp,500,REASON_EFFECT,true)
	Duel.RDComplete()
end
