--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 调皮宝贝喵喵猫  (ID: 25725326)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Rock
-- ATK 1000 | LINK
-- Setcode: 288
--
-- Effect Text:
-- 4星以下的「调皮宝贝」怪兽1只
-- 自己对「调皮宝贝喵喵猫」1回合只能有1次连接召唤，那个效果1回合只能使用1次。
-- ①：对方回合自己场上的「调皮宝贝」怪兽为让效果发动而把自身解放的场合，可以作为代替把场上·墓地的这张卡除外。
--[[ __CARD_HEADER_END__ ]]

--プランキッズ・ミュー
function c25725326.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c25725326.mfilter,1,1)
	c:EnableReviveLimit()
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c25725326.regcon)
	e1:SetOperation(c25725326.regop)
	c:RegisterEffect(e1)
	--release replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(25725326)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetCountLimit(1,25725326)
	e2:SetCondition(c25725326.repcon)
	c:RegisterEffect(e2)
end
function c25725326.mfilter(c)
	return c:IsLevelBelow(4) and c:IsLinkSetCard(0x120)
end
function c25725326.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c25725326.regop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTarget(c25725326.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c25725326.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsCode(25725326) and bit.band(sumtype,SUMMON_TYPE_LINK)==SUMMON_TYPE_LINK
end
function c25725326.repcon(e)
	return Duel.GetTurnPlayer()==1-e:GetHandlerPlayer()
end
