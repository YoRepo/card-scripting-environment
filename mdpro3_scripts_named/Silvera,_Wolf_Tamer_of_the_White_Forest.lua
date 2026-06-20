--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 白森林的魔狼 森厄狼  (ID: 41924516)
-- Type: Monster / Effect / Tuner / Synchro
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 6
-- ATK 1900 | DEF 2400
-- Setcode: 433
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- ①：这张卡特殊召唤的场合才能发动。对方场上的表侧表示怪兽全部变成里侧守备表示。
-- ②：只要这张卡在怪兽区域存在，自己场上的幻想魔族·魔法师族的同调怪兽攻击力上升500，向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的2倍数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--白き森の魔狼シルウィア
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(s.postg)
	e1:SetOperation(s.posop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(s.atktg)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_PIERCE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(s.atktg)
	e3:SetValue(DOUBLE_DAMAGE)
	c:RegisterEffect(e3)
end
function s.posfilter(c)
	return c:IsPosition(POS_FACEUP) and c:IsCanTurnSet()
end
function s.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.posfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(s.posfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function s.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.posfilter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
	end
end
function s.atktg(e,c)
	return c:IsType(TYPE_SYNCHRO) and c:IsRace(RACE_ILLUSION+RACE_SPELLCASTER)
end
