--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 召唤女巫  (ID: 61665245)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Spellcaster
-- ATK 2400 | LINK
--
-- Effect Text:
-- 衍生物以外的相同种族的怪兽2只以上
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡连接召唤的场合才能发动。从手卡把1只怪兽效果无效在作为这张卡所连接区的对方场上守备表示特殊召唤。那之后，可以把和这个效果特殊召唤的怪兽相同种族的1只怪兽从卡组效果无效守备表示特殊召唤。这个效
-- 果从卡组特殊召唤过的回合，自己不是原本种族和从卡组特殊召唤的那只怪兽相同的怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--サモン・ソーサレス
function c61665245.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.NOT(aux.FilterBoolFunction(Card.IsLinkType,TYPE_TOKEN)),2,99,c61665245.lcheck)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(61665245,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,61665245)
	e1:SetCondition(c61665245.spcon)
	e1:SetTarget(c61665245.sptg)
	e1:SetOperation(c61665245.spop)
	c:RegisterEffect(e1)
end
function c61665245.lcheck(g)
	return aux.SameValueCheck(g,Card.GetLinkRace)
end
function c61665245.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c61665245.spfilter1(c,e,tp,zone)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE,1-tp,zone)
end
function c61665245.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local zone=e:GetHandler():GetLinkedZone(1-tp)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
		and Duel.IsExistingMatchingCard(c61665245.spfilter1,tp,LOCATION_HAND,0,1,nil,e,tp,zone) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c61665245.spfilter2(c,e,tp,rac)
	return c:IsRace(rac) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c61665245.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local zone=c:GetLinkedZone(1-tp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c61665245.spfilter1,tp,LOCATION_HAND,0,1,1,nil,e,tp,zone):GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE,zone) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
		Duel.SpecialSummonComplete()
		local g=Duel.GetMatchingGroup(c61665245.spfilter2,tp,LOCATION_DECK,0,nil,e,tp,tc:GetRace())
		if #g>0 and Duel.GetMZoneCount(tp)>0 and Duel.SelectYesNo(tp,aux.Stringid(61665245,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sc=g:Select(tp,1,1,nil):GetFirst()
			if Duel.SpecialSummonStep(sc,0,tp,tp,false,false,POS_FACEUP_DEFENSE) then
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_DISABLE)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD)
				sc:RegisterEffect(e1)
				local e2=Effect.CreateEffect(c)
				e2:SetType(EFFECT_TYPE_SINGLE)
				e2:SetCode(EFFECT_DISABLE_EFFECT)
				e2:SetValue(RESET_TURN_SET)
				e2:SetReset(RESET_EVENT+RESETS_STANDARD)
				sc:RegisterEffect(e2)
				local e3=Effect.CreateEffect(c)
				e3:SetType(EFFECT_TYPE_FIELD)
				e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
				e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
				e3:SetTargetRange(1,0)
				e3:SetTarget(c61665245.splimit)
				e3:SetLabel(sc:GetOriginalRace())
				e3:SetReset(RESET_PHASE+PHASE_END)
				Duel.RegisterEffect(e3,tp)
				Duel.SpecialSummonComplete()
			end
		end
	end
end
function c61665245.splimit(e,c)
	return c:GetOriginalRace()&e:GetLabel()==0
end
