--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 鬼计雪女  (ID: 54490275)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 2
-- ATK 1000 | DEF 800
-- Setcode: 141
--
-- Effect Text:
-- 自己场上有名字带有「鬼计」的怪兽存在的场合才能让这张卡表侧表示召唤。这张卡1回合只有1次可以变成里侧守备表示。此外，这张卡被战斗破坏送去墓地时才能发动。让把这张卡破坏的怪兽变成里侧守备表示，不能把表示
-- 形式变更。
--[[ __CARD_HEADER_END__ ]]

--ゴーストリックの雪女
function c54490275.initial_effect(c)
	--summon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c54490275.sumcon)
	c:RegisterEffect(e1)
	--turn set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(54490275,0))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c54490275.postg)
	e2:SetOperation(c54490275.posop)
	c:RegisterEffect(e2)
	--change pos
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(54490275,1))
	e3:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetCondition(c54490275.poscon2)
	e3:SetTarget(c54490275.postg2)
	e3:SetOperation(c54490275.posop2)
	c:RegisterEffect(e3)
end
function c54490275.sfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8d)
end
function c54490275.sumcon(e)
	return not Duel.IsExistingMatchingCard(c54490275.sfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c54490275.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(54490275)==0 end
	c:RegisterFlagEffect(54490275,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c54490275.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
function c54490275.poscon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
		and e:GetHandler():GetReasonCard():IsRelateToBattle()
end
function c54490275.postg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local rc=e:GetHandler():GetReasonCard()
	if chk==0 then return rc:IsCanTurnSet() end
	Duel.SetTargetCard(rc)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,rc,1,0,0)
end
function c54490275.posop2(e,tp,eg,ep,ev,re,r,rp)
	local rc=Duel.GetFirstTarget()
	if rc:IsFaceup() and rc:IsRelateToEffect(e) then
		Duel.ChangePosition(rc,POS_FACEDOWN_DEFENSE)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		rc:RegisterEffect(e1)
	end
end
