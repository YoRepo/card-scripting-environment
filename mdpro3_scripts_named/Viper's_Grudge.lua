--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 毒蛇的怨念  (ID: 1683982)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：只要这张卡在魔法与陷阱区域存在，爬虫类族以外的自己怪兽不能攻击，不能把效果发动。
-- ②：自己场上的表侧表示的爬虫类族怪兽被战斗破坏的场合或者被送去墓地的场合才能发动。从卡组把1只4星以下的爬虫类族怪兽特殊召唤。
-- ③：魔法与陷阱区域的这张卡被破坏的场合才能发动。除外的自己的爬虫类族怪兽全部回到墓地。
--[[ __CARD_HEADER_END__ ]]

--毒蛇の怨念
function c1683982.initial_effect(c)
	--activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c1683982.atktg)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_TRIGGER)
	c:RegisterEffect(e2)
	--SpecialSummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1683982,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,1683982)
	e3:SetCondition(c1683982.spcon)
	e3:SetTarget(c1683982.sptg)
	e3:SetOperation(c1683982.spop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCondition(c1683982.spcon2)
	c:RegisterEffect(e4)
	--return to grave
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(1683982,2))
	e6:SetCategory(CATEGORY_TOGRAVE)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetCode(EVENT_DESTROYED)
	e6:SetCountLimit(1,1683983)
	e6:SetCondition(c1683982.tgcon)
	e6:SetTarget(c1683982.tgtg)
	e6:SetOperation(c1683982.tgop)
	c:RegisterEffect(e6)
end
function c1683982.atktg(e,c)
	return not c:IsRace(RACE_REPTILE)
end
function c1683982.cfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsReason(REASON_BATTLE) and c:GetPreviousRaceOnField()&RACE_REPTILE~=0
end
function c1683982.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c1683982.cfilter,1,nil,tp)
end
function c1683982.cfilter2(c,tp)
	return not c:IsReason(REASON_BATTLE) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:GetPreviousRaceOnField()&RACE_REPTILE~=0 and c:IsRace(RACE_REPTILE) and c:IsPreviousPosition(POS_FACEUP)
end
function c1683982.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c1683982.cfilter2,1,nil,tp)
end
function c1683982.spfilter(c,e,tp)
	return c:IsRace(RACE_REPTILE) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1683982.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c1683982.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c1683982.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c1683982.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c1683982.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_SZONE)
end
function c1683982.filter(c,e,tp)
	return c:IsRace(RACE_REPTILE) and c:IsFaceup()
end
function c1683982.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1683982.filter,tp,LOCATION_REMOVED,0,1,nil) end
	local g=Duel.GetMatchingGroup(c1683982.filter,tp,LOCATION_REMOVED,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,#g,0,0)
end
function c1683982.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c1683982.filter,tp,LOCATION_REMOVED,0,nil)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_RETURN)
end
