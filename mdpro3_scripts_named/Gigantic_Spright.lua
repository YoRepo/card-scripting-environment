--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 巨大喷流卫星闪灵  (ID: 54498517)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Thunder
-- Rank 2
-- ATK 1600 | DEF 1600
-- Setcode: 384
--
-- Effect Text:
-- 2星怪兽×2
-- 这张卡超量召唤的场合，可以让自己场上的连接2怪兽作为2星怪兽来成为素材。这个卡名的②的效果1回合只能使用1次。
-- ①：有融合·同调·超量·连接怪兽的其中任意种在作为超量素材中的这张卡的原本攻击力变成2倍。
-- ②：自己主要阶段才能发动。自己场上1个超量素材取除，从卡组把1只2星怪兽特殊召唤。这个效果的发动后，直到回合结束时双方不是2星·2阶·连接2的怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ギガンティック・スプライト
function c54498517.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedureLevelFree(c,c54498517.mfilter,nil,2,2)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetCondition(c54498517.adcon)
	e1:SetValue(c54498517.atkval)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,54498517)
	e2:SetTarget(c54498517.sptg)
	e2:SetOperation(c54498517.spop)
	c:RegisterEffect(e2)
end
function c54498517.mfilter(c,xyzc)
	return c:IsXyzLevel(xyzc,2) or c:IsLink(2)
end
function c54498517.adcon(e)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsType,1,nil,TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK)
end
function c54498517.atkval(e,c)
	return c:GetBaseAttack()*2
end
function c54498517.spfilter(c,e,tp)
	return c:IsLevel(2) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c54498517.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckRemoveOverlayCard(tp,1,0,1,REASON_EFFECT)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c54498517.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c54498517.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c54498517.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if Duel.RemoveOverlayCard(tp,1,0,1,1,REASON_EFFECT)~=0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c54498517.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c54498517.splimit(e,c)
	return not c:IsLevel(2) and not c:IsRank(2) and not c:IsLink(2)
end
