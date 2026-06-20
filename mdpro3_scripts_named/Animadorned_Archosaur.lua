--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 珠玉兽-运算主龙  (ID: 98022050)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dinosaur
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤的场合才能发动。「珠玉兽-运算主龙」以外的自己的手卡·场上（表侧表示）1只恐龙族怪兽破坏。那之后，原本等级和那只破坏的怪兽相同的1只爬虫类族·海龙族·鸟兽族怪兽或者1张「进化药
-- 」魔法卡从卡组加入手卡。
--[[ __CARD_HEADER_END__ ]]

--珠玉獣－アルゴザウルス
function c98022050.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98022050,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,98022050)
	e1:SetTarget(c98022050.destg)
	e1:SetOperation(c98022050.desop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c98022050.desfilter(c,tp,solve)
	return c:IsRace(RACE_DINOSAUR) and not c:IsCode(98022050) and (c:IsFaceup() or c:IsLocation(LOCATION_HAND))
		and (solve or Duel.IsExistingMatchingCard(c98022050.thfilter,tp,LOCATION_DECK,0,1,nil,c:GetOriginalLevel()))
end
function c98022050.thfilter(c,lv)
	return ((c:GetOriginalLevel()==lv and c:IsRace(RACE_REPTILE+RACE_SEASERPENT+RACE_WINDBEAST))
		or (c:IsSetCard(0x10e) and c:IsType(TYPE_SPELL))) and c:IsAbleToHand()
end
function c98022050.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98022050.desfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,tp) end
	local g=Duel.GetMatchingGroup(c98022050.desfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c98022050.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c98022050.desfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,tp)
	if g:GetCount()==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		g=Duel.SelectMatchingCard(tp,c98022050.desfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,tp,true)
	end
	local tc=g:GetFirst()
	if tc and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		local lv=tc:GetOriginalLevel()
		if Duel.IsExistingMatchingCard(c98022050.thfilter,tp,LOCATION_DECK,0,1,nil,lv) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local tg=Duel.SelectMatchingCard(tp,c98022050.thfilter,tp,LOCATION_DECK,0,1,1,nil,lv)
			Duel.SendtoHand(tg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tg)
		end
	end
end
