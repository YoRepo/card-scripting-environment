--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 光道猎犬 雷光  (ID: 21502796)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Beast
-- Level 2
-- ATK 200 | DEF 100
-- Setcode: 56
--
-- Effect Text:
-- ①：这张卡反转的场合发动。可以选场上1张卡破坏。从自己卡组上面把3张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ライトロード・ハンター ライコウ
function c21502796.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21502796,0))
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c21502796.target)
	e1:SetOperation(c21502796.operation)
	c:RegisterEffect(e1)
end
function c21502796.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,3)
end
function c21502796.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(21502796,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,1,1,nil)
		Duel.HintSelection(sg)
		Duel.Destroy(sg,REASON_EFFECT)
	end
	Duel.DiscardDeck(tp,3,REASON_EFFECT)
end
