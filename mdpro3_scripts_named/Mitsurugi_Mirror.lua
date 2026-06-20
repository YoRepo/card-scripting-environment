--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 巳剑之神镜  (ID: 49721684)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 451
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的爬虫类族怪兽解放，从自己的手卡·墓地把1只爬虫类族仪式怪兽仪式召唤。
-- ②：这张卡在墓地存在的状态，自己场上的「天丛云之巳剑」「布都御魂之巳剑」「天羽羽斩之巳剑」的其中任意种被解放的场合才能发动。这张卡回到卡组。
--[[ __CARD_HEADER_END__ ]]

--巳剣之神鏡
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,13332685,19899073,55397172)
	--Activate
	local e1=aux.AddRitualProcGreater2(c,s.spfilter,LOCATION_HAND+LOCATION_GRAVE,nil,s.mfilter,true)
	e1:SetCountLimit(1,id)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_RELEASE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.tdcon)
	e2:SetTarget(s.tdtg)
	e2:SetOperation(s.tdop)
	c:RegisterEffect(e2)
end
function s.spfilter(c)
	return c:IsRace(RACE_REPTILE)
end
function s.mfilter(c)
	return c:IsRace(RACE_REPTILE)
end
function s.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousControler(tp)
		and (c:GetPreviousCodeOnField()==13332685 or c:GetPreviousCodeOnField()==19899073 or c:GetPreviousCodeOnField()==55397172)
end
function s.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp) and not eg:IsContains(e:GetHandler())
end
function s.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeck() end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function s.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() and aux.NecroValleyFilter()(c) then
		Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
