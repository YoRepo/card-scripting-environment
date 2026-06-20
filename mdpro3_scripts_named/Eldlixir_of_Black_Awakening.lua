--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 黑化觉醒之黄金国永生药  (ID: 68829754)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 8514
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：从手卡·卡组把1只不死族怪兽守备表示特殊召唤。自己场上没有「黄金国巫妖」怪兽存在的场合，这个效果不是「黄金国巫妖」怪兽不能特殊召唤。这张卡的发动后，直到回合结束时自己不是不死族怪兽不能特殊召唤。
-- ②：把墓地的这张卡除外才能发动。从卡组把1张「黄金乡」魔法·陷阱卡在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--黒き覚醒のエルドリクシル
function c68829754.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68829754,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,68829754)
	e1:SetTarget(c68829754.target)
	e1:SetOperation(c68829754.activate)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(68829754,1))
	e2:SetCategory(CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,68829754)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c68829754.settg)
	e2:SetOperation(c68829754.setop)
	c:RegisterEffect(e2)
end
function c68829754.filter(c)
	return c:IsSetCard(0x1142) and c:IsFaceup()
end
function c68829754.spfilter(c,e,tp,check)
	return c:IsRace(RACE_ZOMBIE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
		and (check or c:IsSetCard(0x1142))
end
function c68829754.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chk1=Duel.IsExistingMatchingCard(c68829754.filter,tp,LOCATION_MZONE,0,1,nil)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c68829754.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp,chk1)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c68829754.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local chk1=Duel.IsExistingMatchingCard(c68829754.filter,tp,LOCATION_MZONE,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c68829754.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp,chk1)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetTargetRange(1,0)
		e1:SetTarget(c68829754.splimit)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c68829754.splimit(e,c)
	return not c:IsRace(RACE_ZOMBIE)
end
function c68829754.stfilter(c)
	return c:IsSetCard(0x143) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c68829754.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c68829754.stfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c68829754.setop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c68829754.stfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SSet(tp,g)
	end
end
