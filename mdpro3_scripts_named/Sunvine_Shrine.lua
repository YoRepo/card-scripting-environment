--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 圣蔓之社  (ID: 27946124)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 4440
--
-- Effect Text:
-- 自己场上有「圣天树」连接怪兽存在的场合，把1张手卡送去墓地才能把这张卡发动。
-- ①：只要这张卡在魔法与陷阱区域存在，自己不是植物族怪兽不能从额外卡组特殊召唤。
-- ②：1回合1次，可以发动。从自己墓地选1只4星以下的植物族通常怪兽特殊召唤。
-- ③：对方结束阶段，把魔法与陷阱区域的表侧表示的这张卡送去墓地，以自己墓地1张永续陷阱卡为对象才能发动。那张卡在自己的魔法与陷阱区域盖放。
--[[ __CARD_HEADER_END__ ]]

--聖蔓の社
function c27946124.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c27946124.cost)
	e1:SetCondition(c27946124.con)
	c:RegisterEffect(e1)
	--disable spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c27946124.splimit)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(27946124,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c27946124.sptg)
	e3:SetOperation(c27946124.spop)
	c:RegisterEffect(e3)
	--to deck
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(27946124,1))
	e4:SetCategory(CATEGORY_SSET)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCountLimit(1)
	e4:SetCost(c27946124.setcost)
	e4:SetCondition(c27946124.setcon)
	e4:SetTarget(c27946124.settg)
	e4:SetOperation(c27946124.setop)
	c:RegisterEffect(e4)
end
function c27946124.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,1,1,REASON_COST)
end
function c27946124.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK) and c:IsSetCard(0x2158)
end
function c27946124.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c27946124.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c27946124.splimit(e,c)
	return c:IsLocation(LOCATION_EXTRA) and not c:IsRace(RACE_PLANT)
end
function c27946124.spfilter(c,e,tp)
	return c:IsRace(RACE_PLANT) and c:IsType(TYPE_NORMAL) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c27946124.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c27946124.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c27946124.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c27946124.spfilter),tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c27946124.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c27946124.setcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c27946124.setfilter(c)
	return c:IsType(TYPE_CONTINUOUS) and c:IsType(TYPE_TRAP) and c:IsSSetable(true)
end
function c27946124.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c27946124.setfilter(chkc) end
	if chk==0 then return Duel.GetSZoneCount(tp,e:GetHandler())>0
		and Duel.IsExistingTarget(c27946124.setfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local sg=Duel.SelectTarget(tp,c27946124.setfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,sg,1,0,0)
end
function c27946124.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SSet(tp,tc)
	end
end
