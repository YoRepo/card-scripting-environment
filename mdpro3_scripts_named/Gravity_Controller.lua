--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 重力控制者  (ID: 23656668)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Psychic
-- ATK 1000 | LINK
--
-- Effect Text:
-- 连接怪兽以外的额外怪兽区域的怪兽1只
-- 这张卡在连接召唤的回合不能作为连接素材。
-- ①：额外怪兽区域的这张卡不会被和主要怪兽区域的怪兽的战斗破坏。
-- ②：这张卡和额外怪兽区域的对方怪兽进行战斗的伤害步骤开始时才能发动。那只对方怪兽和这张卡回到卡组。
--[[ __CARD_HEADER_END__ ]]

--グラビティ・コントローラー
function c23656668.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,c23656668.mfilter,1,1)
	--cannot link material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e1:SetValue(c23656668.lmlimit)
	c:RegisterEffect(e1)
	--battle indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c23656668.indes)
	c:RegisterEffect(e2)
	--to deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(23656668,0))
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_START)
	e3:SetCondition(c23656668.tdcon)
	e3:SetTarget(c23656668.tdtg)
	e3:SetOperation(c23656668.tdop)
	c:RegisterEffect(e3)
end
function c23656668.mfilter(c)
	return not c:IsLinkType(TYPE_LINK) and c:GetSequence()>4
end
function c23656668.lmlimit(e)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_LINK) and c:GetTurnID()==Duel.GetTurnCount()
end
function c23656668.indes(e,c)
	return e:GetHandler():GetSequence()>4 and c:GetSequence()<=4
end
function c23656668.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	e:SetLabelObject(tc)
	return tc and tc:IsControler(1-tp) and tc:GetSequence()>4
end
function c23656668.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if chk==0 then return tc and c:IsAbleToDeck() and tc:IsAbleToDeck() end
	local g=Group.FromCards(c,tc)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,2,0,0)
end
function c23656668.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if not c:IsRelateToBattle() then return end
	if tc and tc:IsRelateToBattle() and tc:IsControler(1-tp) then
		local g=Group.FromCards(c,tc)
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
