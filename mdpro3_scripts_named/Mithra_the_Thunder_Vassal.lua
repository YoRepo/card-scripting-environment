--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 雷帝家臣 密特拉  (ID: 22404675)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 2
-- ATK 800 | DEF 1000
--
-- Effect Text:
-- 「雷帝家臣 密特拉」的①②的效果1回合各能使用1次。
-- ①：自己主要阶段才能发动。这张卡从手卡特殊召唤，在对方场上把1只「家臣衍生物」（雷族·光·1星·攻800/守1000）守备表示特殊召唤。这个回合，自己不能从额外卡组把怪兽特殊召唤。
-- ②：这张卡为上级召唤而被解放的场合才能发动。这个回合，自己在通常召唤外加上只有1次，自己主要阶段可以上级召唤。
--[[ __CARD_HEADER_END__ ]]

--雷帝家臣ミスラ
function c22404675.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,22404675)
	e1:SetTarget(c22404675.sptg)
	e1:SetOperation(c22404675.spop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_RELEASE)
	e2:SetCountLimit(1,22404676)
	e2:SetCondition(c22404675.sumcon)
	e2:SetTarget(c22404675.sumtg)
	e2:SetOperation(c22404675.sumop)
	c:RegisterEffect(e2)
end
function c22404675.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,22404676,0,TYPES_TOKEN_MONSTER,800,1000,1,RACE_THUNDER,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c22404675.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		if Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
			if Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0
				and Duel.IsPlayerCanSpecialSummonMonster(tp,22404676,0,TYPES_TOKEN_MONSTER,800,1000,1,RACE_THUNDER,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENSE) and not Duel.IsPlayerAffectedByEffect(tp,59822133) then
				local token=Duel.CreateToken(tp,22404676)
				Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
			end
		end
		Duel.SpecialSummonComplete()
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c22404675.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c22404675.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_EXTRA)
end
function c22404675.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_SUMMON) and Duel.GetTurnPlayer()==tp
end
function c22404675.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSummon(tp) and Duel.IsPlayerCanAdditionalSummon(tp) end
end
function c22404675.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,22404675)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(22404675,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetValue(0x1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_EXTRA_SET_COUNT)
	Duel.RegisterEffect(e2,tp)
	Duel.RegisterFlagEffect(tp,22404675,RESET_PHASE+PHASE_END,0,1)
end
