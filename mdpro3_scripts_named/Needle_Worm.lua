--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 针虫  (ID: 81843628)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Insect
-- Level 2
-- ATK 750 | DEF 600
-- Setcode: 62
--
-- Effect Text:
-- 反转：对方卡组最上面的5张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ニードルワーム
function c81843628.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81843628,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c81843628.target)
	e1:SetOperation(c81843628.operation)
	c:RegisterEffect(e1)
end
function c81843628.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,5)
end
function c81843628.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,5,REASON_EFFECT)
end
