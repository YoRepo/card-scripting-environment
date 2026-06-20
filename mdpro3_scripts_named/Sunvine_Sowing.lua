--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 圣蔓的播种  (ID: 53286626)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 4440
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把1只「圣种」怪兽特殊召唤，自己受到1000伤害。自己场上没有「圣天树」连接怪兽存在的场合，这个效果不是「圣种之地灵」不能特殊召唤。这张卡的发动后，直到回合结束时自己不是植物族怪兽不能从额外
-- 卡组特殊召唤。
-- ②：自己场上的植物族连接怪兽被战斗或者对方的效果破坏的场合，可以作为代替把墓地的这张卡除外。
--[[ __CARD_HEADER_END__ ]]

--聖蔓の播種
function c53286626.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,53286626+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c53286626.target)
	e1:SetOperation(c53286626.activate)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c53286626.reptg)
	e2:SetValue(c53286626.repval)
	e2:SetOperation(c53286626.repop)
	c:RegisterEffect(e2)
end
function c53286626.spfilter(c,e,tp,check)
	return c:IsSetCard(0x4158) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and (check or c:IsCode(27520594))
end
function c53286626.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK) and c:IsSetCard(0x2158)
end
function c53286626.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local check=Duel.IsExistingMatchingCard(c53286626.cfilter,tp,LOCATION_MZONE,0,1,nil)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c53286626.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,check) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,1000)
end
function c53286626.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		local check=Duel.IsExistingMatchingCard(c53286626.cfilter,tp,LOCATION_MZONE,0,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c53286626.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,check)
		local tc=g:GetFirst()
		if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
			Duel.Damage(tp,1000,REASON_EFFECT)
		end
		Duel.SpecialSummonComplete()
	end
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c53286626.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c53286626.splimit(e,c)
	return not c:IsRace(RACE_PLANT) and c:IsLocation(LOCATION_EXTRA)
end
function c53286626.repfilter(c,tp)
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsControler(tp) and c:IsRace(RACE_PLANT) and c:IsType(TYPE_LINK)
		and (c:IsReason(REASON_BATTLE) or (c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp)) and not c:IsReason(REASON_REPLACE)
end
function c53286626.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c53286626.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c53286626.repval(e,c)
	return c53286626.repfilter(c,e:GetHandlerPlayer())
end
function c53286626.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
