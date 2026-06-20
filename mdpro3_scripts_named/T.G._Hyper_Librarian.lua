--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 科技属 超图书馆员  (ID: 90953320)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Spellcaster
-- Level 5
-- ATK 2400 | DEF 1800
-- Setcode: 39
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- ①：这张卡在怪兽区域存在的状态，自己或对方把同调怪兽同调召唤的场合发动。这张卡在场上表侧表示存在的场合，自己抽1张。
--[[ __CARD_HEADER_END__ ]]

--TG ハイパー・ライブラリアン
function c90953320.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90953320,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c90953320.drcon)
	e1:SetTarget(c90953320.drtg)
	e1:SetOperation(c90953320.drop)
	c:RegisterEffect(e1)
end
function c90953320.drcon(e,tp,eg,ep,ev,re,r,rp)
	local tg=eg:GetFirst()
	return eg:GetCount()==1 and tg~=e:GetHandler() and tg:IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c90953320.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c90953320.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
