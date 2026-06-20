--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 龙剑士 点火烈·凤凰  (ID: 56347375)
-- Type: Monster / Effect / Pendulum
-- Attribute: FIRE
-- Race: Warrior
-- Level 4
-- Pendulum Scales: L7 / R7
-- ATK 1700 | DEF 1900
-- Setcode: 13107399
--
-- Effect Text:
-- ←7 【灵摆】 7→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：自己主要阶段才能发动。从自己的额外卡组（表侧）让1只灵摆怪兽回到卡组。那之后，除灵摆怪兽外的1只「龙剑士」怪兽或「点火骑士」怪兽从卡组加入手卡。
-- 【怪兽效果】
-- 这个卡名在规则上也当作「点火骑士」卡使用。这个卡名的怪兽效果1回合只能使用1次。
-- ①：场上的这张卡被战斗·效果破坏的场合才能发动。除「龙剑士 点火烈·凤凰」外的1只「龙剑士」怪兽或「点火骑士」怪兽从卡组特殊召唤。这个效果特殊召唤的怪兽当作调整使用。
--[[ __CARD_HEADER_END__ ]]

--竜剣士イグニスP
function c56347375.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,56347375)
	e1:SetTarget(c56347375.thtg)
	e1:SetOperation(c56347375.thop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,56347376)
	e2:SetCondition(c56347375.spcon)
	e2:SetTarget(c56347375.sptg)
	e2:SetOperation(c56347375.spop)
	c:RegisterEffect(e2)
end
function c56347375.tdfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsFaceup() and c:IsAbleToDeck()
end
function c56347375.thfilter(c)
	return c:IsSetCard(0xc7,0xc8) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c56347375.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c56347375.tdfilter,tp,LOCATION_EXTRA,0,1,nil)
		and Duel.IsExistingMatchingCard(c56347375.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c56347375.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local tc=Duel.SelectMatchingCard(tp,c56347375.tdfilter,tp,LOCATION_EXTRA,0,1,1,nil):GetFirst()
	if tc and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_DECK) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c56347375.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.BreakEffect()
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
function c56347375.spcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c56347375.spfilter(c,e,tp)
	return c:IsSetCard(0xc7,0xc8) and not c:IsCode(56347375) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c56347375.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c56347375.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c56347375.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c56347375.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if tc then
		if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_ADD_TYPE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(TYPE_TUNER)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
		end
		Duel.SpecialSummonComplete()
	end
end
