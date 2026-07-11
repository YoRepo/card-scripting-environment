--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Goldd, Wu-Lord of Dark World  (ID: 78004197)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 5
-- ATK 2300 | DEF 1400
-- Setcode: 0x6
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is discarded to the GY by card effect: If it was discarded from your hand to your GY by
-- an opponent's card effect, you can target up to 2 cards your opponent controls; Special Summon this
-- card, then destroy those targets (if any).
--[[ __CARD_HEADER_END__ ]]

--暗黒界の武神 ゴルド
function c78004197.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(78004197,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c78004197.spcon)
	e1:SetTarget(c78004197.sptg)
	e1:SetOperation(c78004197.spop)
	c:RegisterEffect(e1)
end
function c78004197.spcon(e,tp,eg,ep,ev,re,r,rp)
	e:SetLabel(e:GetHandler():GetPreviousControler())
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) and bit.band(r,0x4040)==0x4040
end
function c78004197.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return true end
	if rp==1-tp and tp==e:GetLabel() and Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(78004197,1)) then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,2,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
		e:SetLabel(1)
	else
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
		e:SetProperty(0)
		e:SetLabel(0)
	end
end
function c78004197.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)>0 and e:GetLabel()==1 then
		Duel.BreakEffect()
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
		if not g then return end
		local sg=g:Filter(Card.IsRelateToEffect,nil,e)
		Duel.Destroy(sg,REASON_EFFECT)
	end
end
