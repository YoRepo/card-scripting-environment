--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 宝石骑士女郎·琉璃  (ID: 47611119)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level 5
-- ATK 2400 | DEF 1000
-- Setcode: 4167
--
-- Effect Text:
-- 「宝石骑士·小琉」＋「宝石骑士」怪兽
-- 这张卡用以上记的卡为融合素材的融合召唤才能从额外卡组特殊召唤。自己对「宝石骑士女郎·琉璃」1回合只能有1次特殊召唤。
-- ①：1回合1次，自己主要阶段才能发动。从卡组·额外卡组把1只「宝石骑士」怪兽送去墓地，给与对方为场上的特殊召唤的怪兽数量×500伤害。
--[[ __CARD_HEADER_END__ ]]

--ジェムナイトレディ・ラピスラズリ
function c47611119.initial_effect(c)
	c:SetSPSummonOnce(47611119)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,99645428,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1047),1,false,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c47611119.splimit)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE+CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c47611119.damtg)
	e2:SetOperation(c47611119.damop)
	c:RegisterEffect(e2)
end
function c47611119.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c47611119.filter(c)
	return c:IsSetCard(0x1047) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c47611119.ctfilter(c)
	return c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c47611119.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c47611119.filter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil)
		and Duel.IsExistingMatchingCard(c47611119.ctfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local ct=Duel.GetMatchingGroupCount(c47611119.ctfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*500)
end
function c47611119.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c47611119.filter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
		local ct=Duel.GetMatchingGroupCount(c47611119.ctfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		Duel.Damage(p,ct*500,REASON_EFFECT)
	end
end
