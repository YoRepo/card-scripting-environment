--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 虚龙魔王 无形矢·心灵  (ID: 98287529)
-- Type: Monster / Effect / Ritual
-- Attribute: EARTH
-- Race: Dragon
-- Level 8
-- ATK 2950 | DEF 2500
-- Setcode: 218
--
-- Effect Text:
-- 「无形阵·假面」降临。
-- ①：这张卡仪式召唤成功的场合，下次的对方回合的主要阶段1跳过。
-- ②：只要这张卡在怪兽区域存在，场上的表侧表示的融合·同调·超量怪兽的效果无效化。
-- ③：这张卡从场上送去墓地的场合才能发动。从卡组把「虚龙魔王 无形矢·心灵」以外的1只「龙魔王」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--虚竜魔王アモルファクターP
function c98287529.initial_effect(c)
	c:EnableReviveLimit()
	--skip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c98287529.skipcon)
	e1:SetOperation(c98287529.skipop)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetTarget(c98287529.distg)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c98287529.condition)
	e3:SetTarget(c98287529.target)
	e3:SetOperation(c98287529.operation)
	c:RegisterEffect(e3)
end
function c98287529.skipcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function c98287529.skipop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetCode(EFFECT_SKIP_M1)
	if Duel.GetTurnPlayer()==1-tp then
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetCondition(c98287529.turncon)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
	end
	Duel.RegisterEffect(e1,tp)
end
function c98287529.turncon(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end
function c98287529.distg(e,c)
	return c:IsType(TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ)
end
function c98287529.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c98287529.filter(c)
	return c:IsSetCard(0xda) and not c:IsCode(98287529) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c98287529.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98287529.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c98287529.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c98287529.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
