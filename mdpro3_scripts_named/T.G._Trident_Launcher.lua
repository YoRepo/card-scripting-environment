--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 科技属 三叉戟投掷手  (ID: 50750868)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Machine
-- ATK 2200 | LINK
-- Setcode: 39
--
-- Effect Text:
-- 包含「科技属」调整的效果怪兽2只以上
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡连接召唤的场合才能发动。从自己的手卡·卡组·墓地各把1只「科技属」怪兽在作为这张卡所连接区的自己场上守备表示特殊召唤。这个效果的发动后，直到回合结束时自己不是「科技属」怪兽不能特殊召唤。
-- ②：对方不能把这张卡所连接区的「科技属」同调怪兽作为效果的对象。
--[[ __CARD_HEADER_END__ ]]

--TG トライデント・ランチャー
function c50750868.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2,99,c50750868.lcheck)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50750868,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,50750868)
	e1:SetCondition(c50750868.spcon)
	e1:SetTarget(c50750868.sptg)
	e1:SetOperation(c50750868.spop)
	c:RegisterEffect(e1)
	--cannot be target/battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c50750868.tgtg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
end
function c50750868.lcheck(g,lc)
	return g:IsExists(c50750868.mzfilter,1,nil)
end
function c50750868.mzfilter(c)
	return c:IsLinkSetCard(0x27) and c:IsLinkType(TYPE_TUNER)
end
function c50750868.tgtg(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c) and c:IsSetCard(0x27) and c:IsType(TYPE_SYNCHRO)
end
function c50750868.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c50750868.spfilter(c,e,tp,zone)
	return c:IsSetCard(0x27) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE,tp,zone)
end
function c50750868.spcheck(sg,e,tp,mg)
	return sg:GetClassCount(Card.GetLocation)==#sg
end
function c50750868.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local zone=e:GetHandler():GetLinkedZone(tp)&0x1f
		local ct=Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)
		return ct>2 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
			and Duel.IsExistingMatchingCard(c50750868.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,zone)
			and Duel.IsExistingMatchingCard(c50750868.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,zone)
			and Duel.IsExistingMatchingCard(c50750868.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,zone)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c50750868.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and not Duel.IsPlayerAffectedByEffect(tp,59822133) then
		local zone=c:GetLinkedZone(tp)&0x1f
		local ct=Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)
		if ct>=3 then
			local g1=Duel.GetMatchingGroup(c50750868.spfilter,tp,LOCATION_HAND,0,nil,e,tp,zone)
			local g2=Duel.GetMatchingGroup(c50750868.spfilter,tp,LOCATION_DECK,0,nil,e,tp,zone)
			local g3=Duel.GetMatchingGroup(aux.NecroValleyFilter(c50750868.spfilter),tp,LOCATION_GRAVE,0,nil,e,tp,zone)
			if #g1>0 and #g2>0 and #g3>0 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local sg1=g1:Select(tp,1,1,nil)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local sg2=g2:Select(tp,1,1,nil)
				sg1:Merge(sg2)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local sg3=g3:Select(tp,1,1,nil)
				sg1:Merge(sg3)
				Duel.SpecialSummon(sg1,0,tp,tp,false,false,POS_FACEUP_DEFENSE,zone)
			end
		end
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c50750868.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c50750868.splimit(e,c)
	return not c:IsSetCard(0x27)
end
