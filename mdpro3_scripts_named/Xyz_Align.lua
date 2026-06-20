--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 超量排列  (ID: 60623203)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 115
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：宣言1～12的任意等级，以包含自己场上的怪兽的场上2只表侧表示怪兽为对象才能发动。那些怪兽的等级直到回合结束时变成宣言的等级。这张卡的发动后，直到回合结束时自己不是和作为对象的怪兽的其中任意种相同
-- 种族的怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--エクシーズ・アライン
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.tgfilter(c,e)
	return c:IsFaceup() and c:IsLevelAbove(0) and c:IsCanBeEffectTarget(e)
end
function s.gcheck(sg,tp)
	return sg:IsExists(Card.IsControler,1,nil,tp)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=Duel.GetMatchingGroup(s.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e)
	if chk==0 then return g:CheckSubGroup(s.gcheck,2,2,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,0))
	local sg=g:SelectSubGroup(tp,s.gcheck,false,2,2,tp)
	Duel.SetTargetCard(sg)
	local exlv=0
	if sg:GetClassCount(Card.GetLevel)==1 then
		exlv=sg:GetFirst():GetLevel()
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINGMSG_LVRANK)
	local lv=Duel.AnnounceLevel(tp,1,12,exlv)
	e:SetLabel(lv)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lv=e:GetLabel()
	local race=0
	local g=Duel.GetTargetsRelateToChain():Filter(Card.IsFaceup,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		race=race|tc:GetRace()
		tc=g:GetNext()
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) and race>0 then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetTargetRange(1,0)
		e2:SetLabel(race)
		e2:SetTarget(s.splimit)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
	end
end
function s.splimit(e,c)
	return c:IsLocation(LOCATION_EXTRA) and not c:IsRace(e:GetLabel())
end
