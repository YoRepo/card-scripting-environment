--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 机关傀儡-夜小丑  (ID: 92821268)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 8
-- ATK 800 | DEF 1600
-- Setcode: 4227
--
-- Effect Text:
-- 自己场上的名字带有「机关傀儡」的怪兽被战斗破坏送去自己墓地时，把那只怪兽从游戏中除外才能发动。这张卡从手卡特殊召唤。「机关傀儡-夜小丑」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ギミック・パペット－ナイト・ジョーカー
function c92821268.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92821268,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCountLimit(1,92821268)
	e1:SetCost(c92821268.cost)
	e1:SetTarget(c92821268.target)
	e1:SetOperation(c92821268.operation)
	c:RegisterEffect(e1)
end
function c92821268.cfilter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE) and c:IsSetCard(0x1083)
		and c:IsPreviousControler(tp) and c:IsAbleToRemoveAsCost()
end
function c92821268.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c92821268.cfilter,1,nil,tp) end
	local g=eg:Filter(c92821268.cfilter,nil,tp)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c92821268.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c92821268.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
