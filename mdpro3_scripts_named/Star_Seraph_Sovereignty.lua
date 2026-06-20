--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 光天使 天座  (ID: 91110378)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 800 | DEF 2000
-- Setcode: 134
--
-- Effect Text:
-- 把这张卡作为超量召唤的素材的场合，不是以怪兽3只以上为素材的超量召唤不能使用。
-- ①：自己对「光天使」怪兽的召唤·特殊召唤成功的场合才能发动。这张卡从手卡特殊召唤，自己从卡组抽1张。那张抽到的卡是「光天使」怪兽的场合，可以把那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--光天使スローネ
function c91110378.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_XMAT_COUNT_LIMIT)
	--xyz limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_XYZ_MIN_COUNT)
	e1:SetValue(3)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(91110378,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c91110378.spcon)
	e2:SetTarget(c91110378.sptg)
	e2:SetOperation(c91110378.spop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c91110378.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x86) and c:IsSummonPlayer(tp)
end
function c91110378.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c91110378.cfilter,1,nil,tp)
end
function c91110378.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c91110378.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		if Duel.Draw(tp,1,REASON_EFFECT)==0 then return end
		local dc=Duel.GetOperatedGroup():GetFirst()
		if dc:IsSetCard(0x86) and dc:IsCanBeSpecialSummoned(e,0,tp,false,false)
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(91110378,1)) then
			Duel.BreakEffect()
			Duel.SpecialSummon(dc,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
