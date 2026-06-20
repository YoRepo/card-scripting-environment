--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 幻兽机 黑猎鹰  (ID: 4417407)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 4
-- ATK 1200 | DEF 1700
-- Setcode: 4123
--
-- Effect Text:
-- 这张卡攻击宣言时，把1只「幻兽机衍生物」（机械族·风·3星·攻/守0）特殊召唤。这张卡的等级上升自己场上的「幻兽机衍生物」的等级的合计数值。只要自己场上有衍生物存在，这张卡不会被战斗以及效果破坏。此外
-- ，1回合1次，把1只衍生物解放才能发动。选择对方场上1只怪兽变成表侧守备表示。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--幻獣機ブラックファルコン
function c4417407.initial_effect(c)
	--level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(c4417407.lvval)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(aux.tkfcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e3)
	--token
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(4417407,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetTarget(c4417407.sptg)
	e4:SetOperation(c4417407.spop)
	c:RegisterEffect(e4)
	--pos
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(4417407,1))
	e5:SetCategory(CATEGORY_POSITION)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetHintTiming(TIMING_BATTLE_PHASE)
	e5:SetCountLimit(1)
	e5:SetCost(c4417407.poscost)
	e5:SetTarget(c4417407.postg)
	e5:SetOperation(c4417407.posop)
	c:RegisterEffect(e5)
end
function c4417407.lvval(e,c)
	local tp=c:GetControler()
	return Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_MZONE,0,nil,31533705):GetSum(Card.GetLevel)
end
function c4417407.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c4417407.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,31533705,0x101b,TYPES_TOKEN_MONSTER,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) then
		local token=Duel.CreateToken(tp,4417408)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c4417407.poscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsType,1,nil,TYPE_TOKEN) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsType,1,1,nil,TYPE_TOKEN)
	Duel.Release(g,REASON_COST)
end
function c4417407.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition()
end
function c4417407.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c4417407.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c4417407.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	Duel.SelectTarget(tp,c4417407.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c4417407.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not tc:IsPosition(POS_FACEUP_DEFENSE) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
	end
end
