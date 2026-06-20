--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 波动龙 声子龙  (ID: 67556500)
-- Type: Monster / Effect / Tuner / Synchro
-- Attribute: DARK
-- Race: Dragon
-- Level 4
-- ATK 1900 | DEF 800
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这张卡同调召唤成功时，宣言1～3的等级才能发动。这张卡的等级变成宣言的等级。这个效果发动过的回合，自己不能作以这张卡为同调素材的同调召唤以外的特殊召唤。自己对「波动龙
-- 声子龙」1回合只能有1次特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--波動竜フォノン・ドラゴン
function c67556500.initial_effect(c)
	c:SetSPSummonOnce(67556500)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--level
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67556500,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c67556500.lvcon)
	e1:SetTarget(c67556500.lvtg)
	e1:SetOperation(c67556500.lvop)
	c:RegisterEffect(e1)
end
function c67556500.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c67556500.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINGMSG_LVRANK)
	local lv=Duel.AnnounceLevel(tp,1,3)
	e:SetLabel(lv)
end
function c67556500.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local fid=0
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		fid=c:GetRealFieldID()
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetTarget(c67556500.splimit)
	e2:SetLabel(fid)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_MUST_BE_SMATERIAL)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetTargetRange(1,0)
	e3:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e3)
end
function c67556500.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return sumtype~=SUMMON_TYPE_SYNCHRO or e:GetOwner():GetRealFieldID()~=e:GetLabel() or e:GetOwner():IsFacedown()
end
