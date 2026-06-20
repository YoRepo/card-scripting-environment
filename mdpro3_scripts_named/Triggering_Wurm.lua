--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 扳机亚龙  (ID: 95504778)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level 2
-- ATK 600 | DEF 600
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡作为暗属性连接怪兽的连接素材送去墓地的场合才能发动。墓地的这张卡在作为那只连接怪兽所连接区的自己场上攻击表示特殊召唤。这个效果特殊召唤的这张卡不能作为连接素材。
-- ②：这张卡被连接怪兽的所发动的效果所破坏的场合或者所除外的场合发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--トリガー・ヴルム
function c95504778.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95504778,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCountLimit(1,95504778)
	e1:SetCondition(c95504778.spcon)
	e1:SetTarget(c95504778.sptg)
	e1:SetOperation(c95504778.spop)
	c:RegisterEffect(e1)
	aux.CreateMaterialReasonCardRelation(c,e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95504778,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCountLimit(1,95504779)
	e2:SetCondition(c95504778.drcon)
	e2:SetTarget(c95504778.drtg)
	e2:SetOperation(c95504778.drop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e3)
end
function c95504778.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_LINK and c:GetReasonCard():IsAttribute(ATTRIBUTE_DARK)
end
function c95504778.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	if chk==0 then
		local zone=bit.band(rc:GetLinkedZone(tp),0x1f)
		return rc:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK,tp,zone)
	end
	Duel.SetTargetCard(rc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c95504778.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=Duel.GetFirstTarget()
	if not rc:IsRelateToChain() then return end
	local zone=bit.band(rc:GetLinkedZone(tp),0x1f)
	if c:IsRelateToEffect(e) and zone~=0 and Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP_ATTACK,zone) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1,true)
	end
	Duel.SpecialSummonComplete()
end
function c95504778.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT) and re:IsActiveType(TYPE_LINK) and re:IsActivated()
end
function c95504778.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c95504778.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
