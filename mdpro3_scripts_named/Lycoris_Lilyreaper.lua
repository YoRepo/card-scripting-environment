--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 石蒜百合收割者  (ID: 81916745)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Plant
-- Level 5
-- ATK 800 | DEF 2400
--
-- Effect Text:
-- 调整+调整以外的怪兽1只以上
-- 这张卡在自己怪兽区域存在的状态，怪兽从场上被送去对方墓地的场合（伤害步骤也能发动）：自己回复对方墓地的那之内1只怪兽的攻击力数值的基本分。
-- 这张卡在自己墓地存在的状态，对方受到效果伤害的场合（伤害步骤除外）：可以把这张卡除外；持有自己和对方的基本分相差数值以下的攻击力的场上1只怪兽送去墓地。
-- 「石蒜百合收割者」的每个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--Lycoris Lilyreaper
local s,id,o=GetID()
function s.initial_effect(c)
	--Synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--destroy
	local custom_code=aux.RegisterMergedDelayedEvent_ToSingleCard(c,id,EVENT_TO_GRAVE)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(custom_code)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.reccon)
	e1:SetTarget(s.rectg)
	e1:SetOperation(s.recop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.tgcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.tgtg)
	e2:SetOperation(s.tgop)
	c:RegisterEffect(e2)
end
function s.recfilter(c,tp,e)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsControler(1-tp) and c:IsAttackAbove(1) and c:IsType(TYPE_MONSTER)
end
function s.reccon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.recfilter,1,nil,tp)
end
function s.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(s.recfilter,nil,tp,e)
	if chk==0 then return #g>0 end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function s.recop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local mg=Duel.GetTargetsRelateToChain():Filter(s.recfilter,nil,tp,e)
	if #mg>0 and c:IsRelateToChain() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
		local og=mg:Select(tp,1,1,nil)
		local rc=og:GetFirst()
		Duel.HintSelection(og)
		Duel.Recover(tp,rc:GetAttack(),REASON_EFFECT)
	end
end
function s.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and ep~=tp
end
function s.tgfilter(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk) and c:IsAbleToGrave()
end
function s.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,math.abs(Duel.GetLP(tp)-Duel.GetLP(1-tp))) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,PLAYER_ALL,LOCATION_MZONE)
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,s.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,math.abs(Duel.GetLP(tp)-Duel.GetLP(1-tp)))
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
