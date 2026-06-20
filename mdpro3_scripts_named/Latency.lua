--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 延迟天使  (ID: 3560069)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Cyberse
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡因效果从自己墓地加入手卡的场合才能发动。这张卡从手卡特殊召唤。
-- ②：这张卡的①的效果特殊召唤的这张卡作为连接素材送去墓地的场合才能发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--レイテンシ
function c3560069.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3560069,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCountLimit(1,3560069)
	e1:SetCondition(c3560069.spcon)
	e1:SetTarget(c3560069.sptg)
	e1:SetOperation(c3560069.spop)
	c:RegisterEffect(e1)
end
function c3560069.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(r,REASON_EFFECT)~=0 and c:IsPreviousLocation(LOCATION_GRAVE) and c:IsPreviousControler(tp)
end
function c3560069.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c3560069.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(3560069,1))
		e1:SetCategory(CATEGORY_DRAW)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
		e1:SetCode(EVENT_BE_MATERIAL)
		e1:SetCountLimit(1,3560070)
		e1:SetCondition(c3560069.drcon)
		e1:SetTarget(c3560069.drtg)
		e1:SetOperation(c3560069.drop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_LEAVE-RESET_TOGRAVE)
		c:RegisterEffect(e1)
	end
end
function c3560069.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_LINK
end
function c3560069.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c3560069.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
