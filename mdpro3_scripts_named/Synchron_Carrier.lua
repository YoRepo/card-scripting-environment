--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 同调士运送者  (ID: 62125438)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 2
-- ATK 0 | DEF 1000
-- Setcode: 4119
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，自己在通常召唤外加上只有1次，自己主要阶段可以把1只「同调士」怪兽召唤。
-- ②：这张卡在怪兽区域存在，其他的「同调士」怪兽作为战士族·机械族同调怪兽的同调素材送去自己墓地的场合才能发动。在自己场上把1只「同调士衍生物」（机械族·地·2星·攻1000/守0）特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--シンクロン・キャリアー
function c62125438.initial_effect(c)
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62125438,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1017))
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCountLimit(1,62125438)
	e2:SetCondition(c62125438.spcon)
	e2:SetTarget(c62125438.sptg)
	e2:SetOperation(c62125438.spop)
	c:RegisterEffect(e2)
end
function c62125438.filter(c,tp)
	return c:IsSetCard(0x1017) and c:IsType(TYPE_MONSTER) and c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE)
end
function c62125438.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c62125438.filter,1,nil,tp) and r==REASON_SYNCHRO and re:GetHandler():IsRace(RACE_WARRIOR+RACE_MACHINE)
end
function c62125438.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,62125439,0x1017,TYPES_TOKEN_MONSTER,1000,0,2,RACE_MACHINE,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c62125438.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,62125439,0x1017,TYPES_TOKEN_MONSTER,1000,0,2,RACE_MACHINE,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,62125439)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
