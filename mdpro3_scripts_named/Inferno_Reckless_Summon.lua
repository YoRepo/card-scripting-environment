--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 地狱的暴走召唤  (ID: 12247206)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方场上有表侧表示怪兽存在，自己场上只有攻击力1500以下的怪兽1只特殊召唤时才能发动。那只特殊召唤的怪兽的同名怪兽从自己的手卡·卡组·墓地尽可能攻击表示特殊召唤，对方选自身场上1只表侧表示怪兽，
-- 那只怪兽的同名怪兽从自身的手卡·卡组·墓地尽可能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--地獄の暴走召喚
function c12247206.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c12247206.condition)
	e1:SetTarget(c12247206.target)
	e1:SetOperation(c12247206.activate)
	c:RegisterEffect(e1)
end
function c12247206.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and tc:IsLocation(LOCATION_MZONE) and tc:IsControler(tp)
		and tc:IsFaceup() and tc:IsAttackBelow(1500)
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
end
function c12247206.nfilter(c,tc)
	return c:IsCode(tc:GetCode())
end
function c12247206.spfilter1(c,tc,e,tp)
	return c12247206.nfilter(c,tc) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
end
function c12247206.spfilter2(c,tc,e,tp)
	return c12247206.nfilter(c,tc) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c12247206.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then
		local g=Duel.GetMatchingGroup(c12247206.spfilter1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,nil,tc,e,tp)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and g:GetCount()>0
	end
	tc:CreateEffectRelation(e)
	local g=Duel.GetMatchingGroup(c12247206.spfilter1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,nil,tc,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),PLAYER_ALL,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c12247206.sp(g,tp,pos)
	local sc=g:GetFirst()
	while sc do
		Duel.SpecialSummonStep(sc,0,tp,tp,false,false,pos)
		sc=g:GetNext()
	end
end
function c12247206.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft1>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft1=1 end
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c12247206.spfilter1),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,nil,tc,e,tp)
	if ft1>0 and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		if g:GetCount()<=ft1 then
			c12247206.sp(g,tp,POS_FACEUP_ATTACK)
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local fg=g:Select(tp,ft1,ft1,nil)
			c12247206.sp(fg,tp,POS_FACEUP_ATTACK)
		end
	end
	local ft2=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if ft2>1 and Duel.IsPlayerAffectedByEffect(1-tp,59822133) then ft2=1 end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_FACEUP)
	local sg=Duel.SelectMatchingCard(1-tp,Card.IsFaceup,1-tp,LOCATION_MZONE,0,1,1,nil)
	if ft2>0 and sg:GetCount()>0 then
		local g2=Duel.GetMatchingGroup(aux.NecroValleyFilter(c12247206.spfilter2),1-tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,nil,sg:GetFirst(),e,1-tp)
		if g2:GetCount()>0 then
			if g2:GetCount()<=ft2 then
				c12247206.sp(g2,1-tp,POS_FACEUP)
			else
				Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
				local fg=g2:Select(1-tp,ft2,ft2,nil)
				c12247206.sp(fg,1-tp,POS_FACEUP)
			end
		end
	end
	Duel.SpecialSummonComplete()
end
