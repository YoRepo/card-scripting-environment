--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 魔神仪的祝诞  (ID: 86758915)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 279
--
-- Effect Text:
-- 仪式怪兽的降临必需。这个卡名的②的效果1回合只能使用1次。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的「魔神仪」怪兽解放，从手卡把1只仪式怪兽仪式召唤。
-- ②：这张卡在墓地存在的场合，从手卡以及自己场上的表侧表示的卡之中把「魔神仪的祝诞」以外的1张「魔神仪」卡送去墓地才能发动。从卡组把1只「魔神仪」怪兽特殊召唤。那之后，墓地的这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--魔神儀の祝誕
function c86758915.initial_effect(c)
	--Activate
	local e1=aux.AddRitualProcGreater2(c,nil,nil,nil,c86758915.mfilter,true)
	e1:SetDescription(aux.Stringid(86758915,0))
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(86758915,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,86758915)
	e2:SetCost(c86758915.thcost)
	e2:SetTarget(c86758915.thtg)
	e2:SetOperation(c86758915.thop)
	c:RegisterEffect(e2)
end
function c86758915.mfilter(c)
	return c:IsSetCard(0x117)
end
function c86758915.cfilter(c,tp)
	return (c:IsFaceup() or c:IsLocation(LOCATION_HAND)) and c:IsSetCard(0x117) and not c:IsCode(86758915)
		and Duel.GetMZoneCount(tp,c)>0 and c:IsAbleToGraveAsCost()
end
function c86758915.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c86758915.cfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c86758915.cfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c86758915.spfilter(c,e,tp)
	return c:IsSetCard(0x117) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c86758915.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToHand()
		and Duel.IsExistingMatchingCard(c86758915.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
end
function c86758915.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c86758915.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 then
		local c=e:GetHandler()
		if c:IsRelateToEffect(e) then
			Duel.BreakEffect()
			Duel.SendtoHand(c,nil,REASON_EFFECT)
		end
	end
end
