--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: DDD 怒涛王 凯撒  (ID: 3758046)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Fiend
-- Rank 4
-- ATK 2400 | DEF 1200
-- Setcode: 4271
--
-- Effect Text:
-- 恶魔族4星怪兽×2
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方回合，把这张卡1个超量素材取除才能发动。这个回合的战斗阶段结束时，这个回合被破坏的怪兽从自己墓地尽可能特殊召唤。下个回合的准备阶段，自己受到这个效果特殊召唤的怪兽数量×1000伤害。
-- ②：这张卡从场上送去墓地的场合才能发动。从卡组把1张「契约书」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--DDD怒濤王シーザー
function c3758046.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_FIEND),4,2)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3758046,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,3758046)
	e1:SetCondition(aux.bpcon)
	e1:SetCost(c3758046.cost)
	e1:SetOperation(c3758046.operation)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3758046,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,3758047)
	e2:SetCondition(c3758046.thcon)
	e2:SetTarget(c3758046.thtg)
	e2:SetOperation(c3758046.thop)
	c:RegisterEffect(e2)
end
function c3758046.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c3758046.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetCountLimit(1)
	e1:SetOperation(c3758046.spop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c3758046.filter(c,e,tp,id)
	return c:IsReason(REASON_DESTROY) and c:GetTurnID()==id and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c3758046.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local tg=Duel.GetMatchingGroup(aux.NecroValleyFilter(c3758046.filter),tp,LOCATION_GRAVE,0,nil,e,tp,Duel.GetTurnCount())
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local g=nil
	if tg:GetCount()>ft then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		g=tg:Select(tp,ft,ft,nil)
	else
		g=tg
	end
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(3758046,2))
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetCountLimit(1)
		e1:SetLabel(g:GetCount())
		e1:SetReset(RESET_PHASE+PHASE_STANDBY)
		e1:SetOperation(c3758046.damop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c3758046.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,e:GetLabel()*1000,REASON_EFFECT)
end
function c3758046.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c3758046.thfilter(c)
	return c:IsSetCard(0xae) and c:IsAbleToHand()
end
function c3758046.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3758046.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c3758046.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c3758046.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
