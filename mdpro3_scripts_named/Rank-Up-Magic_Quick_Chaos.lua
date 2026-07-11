--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Rank-Up-Magic Quick Chaos  (ID: 33252803)
-- Type: Spell / Quick-Play
-- Setcode: 0x95, 0xcf
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 "Number" Xyz Monster you control, except a "Number C" monster; Special Summon from your
-- Extra Deck, 1 "Number C" monster with the same number in its name as that target, but 1 Rank higher,
-- by using it as the Xyz Material.
-- (This is treated as an Xyz Summon. Transfer its materials to the Summoned monster.)
--[[ __CARD_HEADER_END__ ]]

--RUM－クイック・カオス
function c33252803.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c33252803.target)
	e1:SetOperation(c33252803.activate)
	c:RegisterEffect(e1)
end
function c33252803.filter1(c,e,tp)
	local no=aux.GetXyzNumber(c)
	return c:IsFaceup() and c:IsSetCard(0x48) and not c:IsSetCard(0x1048) and no
		and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
		and Duel.IsExistingMatchingCard(c33252803.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,c:GetRank()+1,no)
end
function c33252803.filter2(c,e,tp,mc,rk,no)
	return c:IsRank(rk) and c:IsSetCard(0x1048) and aux.GetXyzNumber(c)==no and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c33252803.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c33252803.filter1(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c33252803.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp)end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c33252803.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c33252803.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local no=aux.GetXyzNumber(tc)
	if not aux.MustMaterialCheck(tc,tp,EFFECT_MUST_BE_XMATERIAL)
		or tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) or not no then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c33252803.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetRank()+1,no)
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
