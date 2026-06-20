--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 暗黑界的军神 希尔瓦  (ID: 32619583)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 5
-- ATK 2300 | DEF 1400
-- Setcode: 6
--
-- Effect Text:
-- ①：这张卡被效果从手卡丢弃去墓地的场合发动。这张卡特殊召唤。被对方的效果丢弃的场合，再让对方选自身2张手卡用喜欢的顺序回到卡组下面。
--[[ __CARD_HEADER_END__ ]]

--暗黒界の軍神 シルバ
function c32619583.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32619583,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c32619583.spcon)
	e1:SetTarget(c32619583.sptg)
	e1:SetOperation(c32619583.spop)
	c:RegisterEffect(e1)
end
function c32619583.spcon(e,tp,eg,ep,ev,re,r,rp)
	e:SetLabel(e:GetHandler():GetPreviousControler())
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) and bit.band(r,0x4040)==0x4040
end
function c32619583.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c32619583.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)>0
		and rp==1-tp and tp==e:GetLabel() and Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>1 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(1-tp,aux.TRUE,tp,0,LOCATION_HAND,2,2,nil)
		aux.PlaceCardsOnDeckBottom(1-tp,g)
	end
end
