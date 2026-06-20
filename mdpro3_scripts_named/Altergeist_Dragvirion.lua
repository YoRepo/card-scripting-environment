--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 幻变骚灵·拖拽山妪  (ID: 21187631)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Spellcaster
-- Level 6
-- ATK 2200 | DEF 1200
-- Setcode: 259
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：特殊召唤的对方怪兽的攻击宣言时，让自己场上1只「幻变骚灵」怪兽回到持有者手卡才能发动。那次攻击无效。
-- ②：这张卡被解放送去墓地的场合才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--オルターガイスト・ドラッグウィリオン
function c21187631.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21187631,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1,21187631)
	e1:SetCondition(c21187631.atkcon)
	e1:SetCost(c21187631.atkcost)
	e1:SetOperation(c21187631.atkop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21187631,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,21187632)
	e2:SetCondition(c21187631.spcon)
	e2:SetTarget(c21187631.sptg)
	e2:SetOperation(c21187631.spop)
	c:RegisterEffect(e2)
end
function c21187631.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(1-tp) and tc:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c21187631.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x103) and c:IsAbleToHandAsCost()
end
function c21187631.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21187631.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c21187631.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoHand(g,nil,REASON_COST)
end
function c21187631.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c21187631.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_RELEASE)
end
function c21187631.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c21187631.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and aux.NecroValleyFilter()(c) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
