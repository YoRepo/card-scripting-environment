--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 极星邪龙 尤蒙刚德  (ID: 64203620)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 3000 | DEF 3000
-- Setcode: 66
--
-- Effect Text:
-- 这张卡不能通常召唤。场上有「极神」怪兽存在的场合可以从手卡往对方场上守备表示特殊召唤。
-- ①：场上没有「极神」怪兽存在的场合这张卡破坏。
-- ②：只在这张卡在场上表侧表示存在才有1次，表侧守备表示的这张卡变成表侧攻击表示的场合发动。自己受到3000伤害。
--[[ __CARD_HEADER_END__ ]]

--極星邪龍ヨルムンガンド
function c64203620.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64203620,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,1)
	e1:SetCondition(c64203620.spcon)
	c:RegisterEffect(e1)
	--self destory
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_SELF_DESTROY)
	e4:SetCondition(c64203620.descon)
	c:RegisterEffect(e4)
	--damage
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(64203620,1))
	e5:SetCategory(CATEGORY_DAMAGE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e5:SetCode(EVENT_CHANGE_POS)
	e5:SetCountLimit(1)
	e5:SetCondition(c64203620.damcon)
	e5:SetTarget(c64203620.damtg)
	e5:SetOperation(c64203620.damop)
	c:RegisterEffect(e5)
end
function c64203620.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c64203620.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c64203620.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x4b)
end
function c64203620.descon(e)
	return not Duel.IsExistingMatchingCard(c64203620.filter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c64203620.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK) and e:GetHandler():IsPreviousPosition(POS_FACEUP_DEFENSE)
end
function c64203620.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,3000)
end
function c64203620.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
