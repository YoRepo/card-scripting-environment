--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: A警报！  (ID: 26372118)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 395
--
-- Effect Text:
-- 这个卡名在规则上也当作「救援ACE队」卡使用。这个卡名的卡在1回合只能发动1张。
-- ①：从自己墓地把1只「救援ACE队」怪兽加入手卡。自己场上有「救援ACE队 消防栓」存在的场合，也能作为代替从卡组把1只「救援ACE队」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ALERT！
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_GRAVE_ACTION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.checkfilter(c)
	return c:IsCode(37617348) and c:IsFaceup()
end
function s.thfilter(c,check)
	return c:IsSetCard(0x18b) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
		and (c:IsLocation(LOCATION_GRAVE) or check)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local check=Duel.IsExistingMatchingCard(s.checkfilter,tp,LOCATION_ONFIELD,0,1,nil)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,check) end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local check=Duel.IsExistingMatchingCard(s.checkfilter,tp,LOCATION_ONFIELD,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil,check)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
