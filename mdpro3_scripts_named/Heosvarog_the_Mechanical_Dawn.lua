--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 黎铭机 厄俄斯瓦罗格  (ID: 8963089)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Machine
-- Level 7
-- ATK 0 | DEF 2800
--
-- Effect Text:
-- 机械族·光属性怪兽×2
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡融合召唤的场合才能发动。下个回合的准备阶段，把持有融合召唤效果的1张卡从自己墓地加入手卡。
-- ②：对方把魔法·陷阱卡的效果发动时，把自己场上1只表侧表示的机械族·光属性怪兽或者自己墓地2只机械族·光属性怪兽除外才能发动。那个发动无效。
--[[ __CARD_HEADER_END__ ]]

--黎銘機ヘオスヴァローグ
local s,id,o=GetID()
function s.initial_effect(c)
	--material
	aux.AddFusionProcFunRep(c,s.matfilter,2,true)
	c:EnableReviveLimit()
	--search reg
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_GRAVE_ACTION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.thcon)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.negcon)
	e2:SetCost(s.negcost)
	e2:SetTarget(s.negtg)
	e2:SetOperation(s.negop)
	c:RegisterEffect(e2)
end
function s.matfilter(c)
	return c:IsFusionAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_MACHINE)
end
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	e1:SetOperation(s.thop2)
	e1:SetReset(RESET_PHASE+PHASE_STANDBY)
	Duel.RegisterEffect(e1,tp)
end
function s.thfilter(c)
	return c:IsEffectProperty(aux.EffectPropertyFilter(EFFECT_FLAG_FUSION_SUMMON)) and c:IsAbleToHand()
end
function s.thop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,id)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_GRAVE,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.negcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not c:IsStatus(STATUS_BATTLE_DESTROYED) and ep~=tp and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and Duel.IsChainNegatable(ev)
end
function s.rfilter(c)
	return c:IsFaceupEx() and c:IsAbleToRemoveAsCost()
		and c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function s.gcheck(g)
	return (#g==2 and g:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)==2
			or #g==1 and g:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)==1)
end
function s.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(s.rfilter,tp,LOCATION_GRAVE+LOCATION_MZONE,0,nil)
	if chk==0 then return g:CheckSubGroup(s.gcheck,1,2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=g:SelectSubGroup(tp,s.gcheck,false,1,2)
	Duel.Remove(sg,POS_FACEUP,REASON_COST)
end
function s.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function s.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
