--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 业神-不知火  (ID: 26326541)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Zombie
-- Level 5
-- ATK 1900 | DEF 0
-- Setcode: 217
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 自己对「业神-不知火」1回合只能有1次特殊召唤，那个②的效果1回合只能使用1次。
-- ①：这张卡特殊召唤成功的场合，以场上1只怪兽为对象才能发动。那只怪兽的表示形式变更。
-- ②：这张卡被除外的场合才能发动。在自己场上把1只「不知火衍生物」（不死族·炎·1星·攻/守0）特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--業神－不知火
function c26326541.initial_effect(c)
	c:SetSPSummonOnce(26326541)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--position
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26326541,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c26326541.postg)
	e1:SetOperation(c26326541.posop)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26326541,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCountLimit(1,26326541)
	e2:SetTarget(c26326541.tktg)
	e2:SetOperation(c26326541.tkop)
	c:RegisterEffect(e2)
end
function c26326541.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsCanChangePosition() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsCanChangePosition,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,Card.IsCanChangePosition,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c26326541.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
function c26326541.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,26326542,0xd9,TYPES_TOKEN_MONSTER,0,0,1,RACE_ZOMBIE,ATTRIBUTE_FIRE) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c26326541.tkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,26326542,0xd9,TYPES_TOKEN_MONSTER,0,0,1,RACE_ZOMBIE,ATTRIBUTE_FIRE) then return end
	local token=Duel.CreateToken(tp,26326542)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
